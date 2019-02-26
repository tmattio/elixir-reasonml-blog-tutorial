let component = ReasonReact.statelessComponent(__MODULE__);

let make = _children => {
  ...component,
  render: _self => <div> {"Hello World" |> ReasonReact.string} </div>,
};