type route =
  | Home
  | Login
  | CreatePost
  | NotFound;

let mapUrlToRoute = (url: ReasonReact.Router.url) =>
  switch (url.path) {
  | [""]
  | [] => Home
  | ["login"] => Login
  | ["new-post"] => CreatePost
  | _ => NotFound
  };

let mapRouteToUrlPath = (route: route): list(string) =>
  switch (route) {
  | Home => [""]
  | Login => ["login"]
  | CreatePost => ["new-post"]
  | NotFound => ["404"]
  };

let joinUrlPath = (path: list(string)): string =>
  List.fold_left((acc, el) => acc ++ "/" ++ el, "", path);

let routeTo = (route: route, event) =>
  if (!ReactEvent.Mouse.defaultPrevented(event)) {
    ReactEvent.Mouse.preventDefault(event);
    let href = mapRouteToUrlPath(route) |> joinUrlPath;
    ReasonReact.Router.push(href);
  };

let redirect = (route: route) => {
  let href = mapRouteToUrlPath(route) |> joinUrlPath;
  ReasonReact.Router.push(href);
};
