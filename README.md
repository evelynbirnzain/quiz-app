# Device-Agnostic Design Course Project I: Quiz App

A simple cross-platform quiz app built with Flutter and Riverpod.
View the app [here](https://evelynbirnzain.github.io/quiz-app/).

## Description

This quiz app allows users to answer questions about a selection of topics. Users can see their progress overall and for
each topic on a statistics page. It is also possible to specifically practice questions from those topics that the user
does not have a lot of correct answers for yet.

## Challenges

* ListView and sizing: It took me a while to figure out that I have to constrain the size of the ListView somehow when
  putting it into a column to not get an error.
* Providers: I think at least in the beginning I had some misunderstandings about providers and had issues with trying
  to set them in lifecycle methods.
* Futures, AsyncValues etc.: There are a lot of different ways to handle asynchronous data in Flutter, and
  it's not always clear to me which one is the best for a given situation. I ended up using a colorful mix.
* Testing: It took me way too long to realize that a nock interceptor is a one-time thing that has to be set up for each
  individual request instead of answering all request to the registered URL indefinitely. Also, I couldn't seem to get
  the tests to work fully independently of each other, so I have a couple of different test suites now.

## Learnings

* Extracting widgets: I think I got a better feeling for when to extract widgets into their own classes and when to
  leave them in the same class.
* Async data: I got some practice dealing with asynchronous data in Flutter and even though I'm still a bit unsure about
  the best way to do it, I can make it work somehow.
* Provider: I got some practice using Providers (also with arguments) and I think I got a better feeling for when to use
  them and when to use other methods of passing data around.

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  flutter_riverpod: ^2.4.0
  go_router: ^10.1.2
  http: ^1.1.0
  riverpod: ^2.4.0
  shared_preferences: ^2.2.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  test: any
  flutter_lints: ^2.0.0
  nock: ^1.2.3
```