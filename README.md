![](utilitybelt.png)

# NiceUtilities

This package, and attached example project, contains a bunch of tools and tricks we've found useful when developing apps with Swift, and more specifically SwiftUI.

#### Index
 - [The Example Project](#the-example-project)
 - [ContentLoadState](#contentloadstate)
 - [ObservableVM](#observablevm)
 - [Stateful View](#stateful-view)
 - [Dependency Injection](#dependency-injection)
 - [Error Handling](#error-handling)
 - [Cacheing](#cacheing)
 - [Array+Cancellable](#array+cancellable)

## The Example Project

In addition to giving examples of how to use all the utilities included in this package, the example project lays out our current preferred app architecture as of Jan 2023.

This includes sample Services, Repositories, View Models, Views, and some guidance for testing the whole mess.

## ContentLoadState

When creating views, we frequently want to change the state of the view based on the state of the content that view is displaying.

- Loading: The content is currently loading
- NoData: The content has loaded successfully, but is empty.
- HasData: The content has loaded successfully
- Error: Something's gone wrong

## ObservableVM

An observable VM provides a skeleton for a view model that manages a view's content, in addition to communicating with repositories and services.

See our complete [MVVM example project](https://github.com/steamclock/mvvm-ios/) for the full picture.

## Stateful View

StatefulView should be using in combination with `ObservableViewModel`'s `ContentLoadState` to provide a nice starting point for building views that react to their content state.

```
struct AStatefulView: View {
    @ObservedObject var viewModel: AViewModel

    var body: some View {
        StatefulView(
            state: viewModel.contentLoadState,
            hasData: {
                // Your fancy view goes here!
            },
            error: { error in
                ACustomErrorView(error)
            },
            loadingView: {
                Image("cat_toast_gif")
            }
        ).bindToVM(viewModel)
    }
```

See [TODO: ADD FULL EXAMPLE LINK] for a complete example

## Dependency Injection

In the interest of writing more modular, testable, code we recommend providing repositories and services through depenency injection, rather than creating global variables or singletons.

First, create a protocol of the class to be injected and an injection key for it. We do this instead of creating these on the class directly to allow for mocking in tests.
```
protocol UserServiceProtocol {
    func getCurrentUser(id: String) async throws -> User
    func updateUserEmail(id: String, email: String) async throws -> Bool
}

public struct UserServiceKey: InjectionKey {
    public static var currentValue = UserServiceProtocol()
}
```

Then, add your new service to the `InjectedValues`:
```
extension InjectedValues {
    var userService: UserServiceProtocol {
        get { Self[UserServiceKey.self] }
        set { Self[UserServiceKey.self] = newValue }
    } 
    
    // ...
}
```

Now you can create your fill in your user service class, and inject it into view models to use:

```
class AViewModel: ObservableViewModel {
    @Injected(\.userService) private var userService: UserServiceProtocol
```

## Error Handling

Included in this library in a ready-to-be-injected class called `ErrorService`, designed to receive incoming errors through the `error` Subject.

View models can listen to `didReceiveDisplayableError` and handle the results as needed.

We use 3 different protocols to organize and filter errors as they're passed through via the `ErrorService`:

#### Displayable Error

Displayable errors are ones meant to be shown to the user, either as an alert or in-line.

```
enum CreateAccountError: DisplayableError {
    case emailTaken
    case invalidPassword
    
    var title: String {
       switch self {
       case .emailTaken:
           return "Email Address Already Taken"
       case .invalidPassword:
           return "Invalid Password"
       }
   }

   var message: String {
       switch self {
       case .emailTaken:
           return "An account with that email already exists, try logging in?"
       case .invalidPassword:
           return "Your password must contain 8 letters, a capital letter, an emoji, a mathematical equation, your birth sign, and favourite hobbit."
       }
   }
}

```

#### Loggable Error

An error that is meant to generate a log message.

```
enum ApiError: LoggableError {
    case decoding(String)
    
    var typeDescription: StaticString {
        switch self {
        case .decoding:
            return "Decoding Error"
        }
    }

    var errorDescription: String {
        switch self {
        case .decoding(let message):
            return message
        }
    }
}
```

#### Suppressible Error

An error that may not be logged or shown to the user.

```
enum UserEntryError: SuppressibleError {
    case wrongPassword
    case invalidEntry
    
    var shouldDisplay: Bool {
        switch self {
        case .wrongPassword: return true
        case .invalidEntry: return false
        }
    }
}

```

In addition, we provide two common error types: 

- `ConnectivityError` when the app is unable to connect to the internet
- `UnknownError` for when you're all out of other errors

## Cacheing

The provided `CacheService` allows Repositories to create and manage their own caches. While you could inject a shared cache into each repository, we recommend creating a separate cache for each repository unless you've got a good reason not to.

See our [MVVM example project](https://github.com/steamclock/mvvm-ios/) for a complete example.

## Array+Cancellable

Our view models tend to whole a bunch of bindings in an array that we want to clear efficiently when we unbind the view model, this makes that quick and easy.

