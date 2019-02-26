let component = ReasonReact.statelessComponent(__MODULE__);

let make = children => {
  ...component,
  render: _self =>
    <div
      className="bg-grey-lightest font-sans leading-normal tracking-normal min-h-screen">
      <nav id="header" className="fixed w-full z-10 pin-t">
        <div
          className="max-w-md mx-auto flex flex-wrap items-center justify-between mt-0 py-3">
          <div className="pl-4">
            <a
              className="text-black text-base no-underline hover:no-underline font-extrabold text-xl"
              href="#" onClick={Router.routeTo(Home)}>
              {ReasonReact.string("Minimal Blog")}
            </a>
          </div>
          <div
            className="flex-grow flex items-center w-auto block mt-2 mt-0 bg-grey-lightest bg-transparent z-20"
            id="nav-content">
            <ul className="list-reset flex justify-end flex-1 items-center">
              <li className="mr-3">
                <a
                  className="inline-block text-grey-dark no-underline hover:text-black hover:text-underline py-2 px-4"
                  href="#" onClick={Router.routeTo(CreatePost)}>
                  {ReasonReact.string("Create a Post")}
                </a>
              </li>
              <li className="mr-3">
                <a
                  className="inline-block py-2 px-4 text-black font-bold no-underline"
                  href="#" onClick={Router.routeTo(Login)}>
                  {ReasonReact.string("Login")}
                </a>
              </li>
            </ul>
          </div>
        </div>
      </nav>
      <div className="container w-full max-w-md mx-auto pt-20">
        <div
          className="w-full px-4 px-6 text-xl text-grey-darkest leading-normal">
          ...children
        </div>
      </div>
    </div>,
};