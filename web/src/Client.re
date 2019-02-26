let inMemoryCache = ApolloInMemoryCache.createInMemoryCache();

let httpLink =
  ApolloLinks.createHttpLink(~uri="http://localhost:4000/api", ());

let instance =
  ReasonApollo.createApolloClient(~link=httpLink, ~cache=inMemoryCache, ());