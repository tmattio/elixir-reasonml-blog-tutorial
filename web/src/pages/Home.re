type blogPost = {
  id: string,
  title: string,
  body: string,
};

module GetBlogPosts = [%graphql
  {|
  query {
    blogPosts @bsRecord {
      id
      title
      body
    }
  }
  |}
];

module GetBlogPostsQuery = ReasonApollo.CreateQuery(GetBlogPosts);

let viewBlogPost = blogPost => {
  <div>
    <h1 className="font-sans break-normal pt-6 pb-2 text-3xl md:text-4xl">
      {ReasonReact.string(blogPost.title)}
    </h1>
    <p className="py-6"> {ReasonReact.string(blogPost.body)} </p>
    <div className="border-t-2" />
  </div>;
};

let component = ReasonReact.statelessComponent(__MODULE__);

let make = _children => {
  ...component,
  render: _ => {
    <GetBlogPostsQuery>
      ...{({result}) =>
        switch (result) {
        | Loading => <div> {ReasonReact.string("Loading")} </div>
        | Error(error) => <div> {ReasonReact.string(error##message)} </div>
        | Data(response) =>
          <div>
            {Array.map(viewBlogPost, response##blogPosts) |> ReasonReact.array}
          </div>
        }
      }
    </GetBlogPostsQuery>;
  },
};