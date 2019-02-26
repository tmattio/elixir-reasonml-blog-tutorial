# blog-reason-ui

## Installing / Getting started

All the dependencies can be install via your favorite package manager:

```shell
yarn install
```

That's it! You're up and running, you can start the project with:

```shell
yarn start
# In another terminal
yarn webpack
```

## Developing

Assuming you're developing with Visual Studio Code (if you're not, you should definitely give it a shot, it's awesome), all you need to develop is this extension: [vscode-reasonml](https://github.com/reasonml-editor/vscode-reasonml).

This will give you compilation errors in the editor and code intelliscence.

### Building

To build the code, we use `bsb -make-world`. There is an alias `start` in the `package.json` that will run the compilation in watch-mode. Basically, to compile the code, you can run:

```shell
bsb -clean-world
bsb -make-world
```

But most likely, you will only want to run `yarn start` with `yarn webpack` in another terminal.

## Built With

Here's the list of the frameworks or libraries we use in the project:

- [ReasonML](https://reasonml.github.io/en/) - Fast and quality type safe code while leveraging both the JavaScript & OCaml ecosystems.
- [Reason-React](https://github.com/reasonml/reason-react) - Reason bindings for ReactJS.
- [graphql_ppx](https://github.com/mhallin/graphql_ppx) - GraphQL PPX rewriter for Bucklescript/ReasonML.
- [reason-apollo](https://github.com/apollographql/reason-apollo) - React-apollo with Reason.
