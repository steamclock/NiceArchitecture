![](utilitybelt.png)

# NiceArchitecture

This repository is intended to be used as a more detailed reference for how we like to architect SwiftUI apps at Steamclock. [This blog post]()(coming soon™) goes over the architecture at a higher level - including goals, motivations, et cetera, while this repo digs into the specifics of how you might implement NiceArchitecture in the wild.

For the most part, NiceArchitecture sticks with the standard MVVM concepts most mobile developers are familiar with like ViewModels, Repositories, and Services, but adds in a little spice with the concept of ViewCoordinators to handle navigation, and opinions on things like Dependency Injection and how to manage a screen’s load state.

Additionally, we've included a package (also called NiceArchitecture) that provides a bunch of tools and helpers that we've found useful when developing apps under this architecture. You can read more about its contents and what they do below, or check out the [example project](TODO) to see how they work in context.

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

The example project contained in this repository outlines how we like to architect SwiftUI apps as of August 2023. For more context, you should probably read the accompanying blog post (coming soon™) before digging in here.

Once you're up to speed, it's probably best to get started in the PostsCoordinatorView (TODO: Link), then dive into the individual Views and their ViewModels from there. Rather than including more documentation for individual classes here, we've opted to include that information in-line in the example project, to give you a better idea of how things fit together in context. 

Here's a quick reference:

| Class | Example File | Link |
| ----- | ------------ | ---- |
| a | a | a |


## ContentLoadState

When managing Views, we frequently want to make sure that the state of the View matches whatever's happening in the background, and want this to be consistent across each View. To do this, we use a simple enum that contains the most important states a View may be in.

- Loading: The content is currently loading
- NoData: The content has loaded successfully, but is empty.
- HasData: The content has loaded successfully
- Error: Something's gone wrong

To see this in action, check out the [PostsView](TODO).

## ObservableVM

A lot of our ViewModels end up needing to share a lot of the same behaviour, like keeping track of their View's ContentLoadState, binding to Views, handling errors, managing Cancellables, etc. By extending ObservableVM, our ViewModels get a lot of that behaviour automatically, which also helps us make sure we don't forget any of the pieces when adding new ViewModels.

To see a detailed example, check out the [PostsViewModel](TODO).

## StatefulView

Much like ObservableVM provides a starting point for writing new ViewModels, StatefulView provides a starting point for new Views that are bound to ObservableVMs. StatefulView allows a View to dynamically track its ContentLoadState and update appropriately. It also includes default states for the loading, error and noData states.

[PostsView](TODO) contains a more detailed example of how to use this.

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

