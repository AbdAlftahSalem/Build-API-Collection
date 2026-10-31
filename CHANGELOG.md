## 1.1.0

- **Fix (macOS / Linux):** output paths were written with Windows `\\` separators, so on macOS and Linux the collection, the web docs and the routes were saved as files with backslashes in their names next to the controllers folder, and folder names in the collection were full paths. All paths now use the platform separator.
- **Fix:** `@param` query parameters were never added to the request URL. They are now in the URL and in Postman's `query` list.
- **Fix:** collection variables were written as `variables` / `events`; Postman reads `variable` / `event`, so `{{base_url}}` was undefined after import.
- **Fix:** bearer auth used the wrong key and was attached (empty) to public routes. Private routes now get `{{token}}` bearer auth; public routes get none.
- **Fix:** generated Express routes used the method as written (`.GET(`, `.formdata(`). They now use `.get(`, `.post(`, … and end with `module.exports = router;`. The `require()` path points at the real controllers folder and file.
- **Fix:** `formdata` routes are now sent as `POST` (it isn't an HTTP method), and `option` is no longer added as a form field.
- **Fix:** Windows (CRLF) files, indented annotations, several spaces in `@route` and `module.exports.x =` are now read correctly. `@access Private` is recognised (the old `Privet` spelling still works).
- **Fix:** web docs: the variables section overwrote the collection info, and a leftover call threw a JavaScript error on load.
- Invalid JSON in an annotation now names the annotation and the file instead of crashing. Unknown flags show the help and exit with code 64.
- Removed a debug `print` of every body. The collection JSON is now pretty-printed.
- The "add variables? [y/N]" prompts accept Enter as N.
- The code moved under `lib/src/` (standard package layout). `package:thunder_api/thunder_api.dart` exports the commands, the parser and the models.
- Removed the unused `dio` dependency and added `path`. `lints` ^6.0.0, analyzer clean, doc comments on the public API.
- Added a runnable example with sample controllers, 10 tests and GitHub Actions CI.
- README rewritten: install, annotation reference, output layout, generated route example, commands.

## 1.0.2

- Add build route automatically.

## 1.0.1

- Solve bug in body of request.

## 1.0.0

- Initial version.
