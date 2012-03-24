<!-- vim: set expandtab ts=2 sw=2 nowrap ft=markdown ff=unix : -->
I want to know what middlewares are adapted to API server on HTTP.
So I write web applications with multiple programming languages under below conditions.

- Support JSON on HTTP interfaces.
  - JSON number must be returned as number, not string.
- Support HTML template.
  - Use light web framework like Sinatra.
- Support beautiful error notification with HTML for developping.
  - Use middlewares on Rack, PSGI, WSGI and Servlet layer.
- Support profiler.
- Support memcached cache.
- Do unit testing.
- Use MySQL.
  - **Avoid** using O/R mapper.
  - Use SQL builder instead.
  - Settings are loaded from setting file by YAML.
- Split routing definition to multiple files.
  - For multi-person development.
- Modern style :)
  - Handle application's dependencies.
