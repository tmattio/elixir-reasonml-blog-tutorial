open Router;

type state = route;

type action =
  | ChangeRoute(route);

let reducer = (action, _state) =>
  switch (action) {
  | ChangeRoute(route) => ReasonReact.Update(route)
  };

let component = ReasonReact.reducerComponent(__MODULE__);

let make = _children => {
  ...component,
  reducer,
  initialState: () =>
    mapUrlToRoute(ReasonReact.Router.dangerouslyGetInitialUrl()),
  didMount: self => {
    let watcherID =
      ReasonReact.Router.watchUrl(url =>
        self.send(ChangeRoute(url |> mapUrlToRoute))
      );
    self.onUnmount(() => ReasonReact.Router.unwatchUrl(watcherID));
  },
  render: self => {
    switch (self.state) {
    | Home => <Layout> <Home /> </Layout>
    | CreatePost => <Layout> <CreatePost /> </Layout>
    | Login => <Layout> <Login /> </Layout>
    | _ => <Layout> <NotFound /> </Layout>
    };
  },
};