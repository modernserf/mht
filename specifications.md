Media History Timeline
----------------------
The Media History Timeline is a tool to explore the changing landscape of media in the 20th and 21st centuries, with a particular focus on coverage of social justice and resistance movements, corporate consolidation paralleled against the rise of citizen journalism and independent media, and intersections with politics and technology.


Features/Requirements
---------------------
Progressive Enhancement -- information is available in many formats, for any device; more complex presentation for modern browsers, but everyone gets the same content. The app is built in layers, with rich visualizations on top of semantic hypertext on top of a JSON API.
Accessibility
  physical -- Graphics annotated; video/audio captioned; navigable without a mouse
  social -- works on any device; is friendly to low-bandwidth mobile connections
Maintainability -- site can be maintained by non-experts
Interactivity -- users can save their own annotations privately and submit theirs to be added publicly
Freedom -- Code and own content is open source; free to share/cite/remix


Layers and Support
------------------
As stated above, there are three layers to this app: roughly, this translates to the API, the HTML, and the JS presentation layer. While all users will have the option to view the raw data or the HTML version, the presentation layer will only be available to modern browsers which support CSS animation, the HTML5 DOM API and ES5 JavaScript.

While this means several still popular browsers -- IE 8 & 9, as well as Android 2.x -- will have a less visual experience, they will still be supported, as will many older browsers and devices that have been shut out of many contemporary web experiences.


URLs
----
The app is highly URL-driven; every part of the app is accessible via URL and thus citable, bookmarkable, and machine-readable. They are structured two dimensionally, eg:

/event/national-guard-at-wto-protests?tags=black-bloc,indymedia
------------------------------------- -------------------------
              main node                    cross-reference

The path is the node being viewed; the query has the topics being highlighted in the UI. All application state will be fully encoded in the URL -- sharing this link will show the same page with the same cross-references highlighted; the back button will navigate you to the previous topic instead of dumping you back at the home screen.


Data
----
The atomic unit of the timeline is the Event -- a fixed point in time and space with facts and perspectives. An event has:

- Time
- Location
- Perspectives/Sources
  - firsthand accounts (links to PEOPLE)
  - contemporary media accounts (links to ORGANIZATIONS)
  - historical analysis (links to MOVEMENTS)
- Tags
  - stories/themes
  - people/orgs/movements

Sequences of related Events compose into Stories; related stories compose into Themes.
Events can belong to multiple Stories and Stories can belong to multiple Themes.
Themes can also belong to larger themes.

Likewise, as events compose into stories, which compose into themes, people can be affiliated with organizations which are affiliated with movements. This is not strictly hierarchical or taxonomic; it is more about _connection_ than _relation_. One could analogize it as:

    EVENT  -> STORY         -> THEME
    PERSON -> ORGANIZATION  -> MOVEMENT
    ATOM   -> MOLECULE      -> POLYMER




