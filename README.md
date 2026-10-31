<img src="https://raw.githubusercontent.com/AbdAlftahSalem/Build-API-Collection/main/assets/images/logo.png" width="220"/>

# ⚡ Thunder API

[![pub package](https://img.shields.io/pub/v/thunder_api.svg)](https://pub.dev/packages/thunder_api)
[![CI](https://github.com/AbdAlftahSalem/Build-API-Collection/actions/workflows/ci.yml/badge.svg)](https://github.com/AbdAlftahSalem/Build-API-Collection/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

Write a few comments above your Node.js / Express controller methods, and Thunder API builds:

- a **Postman collection** (v2.1 JSON, ready to import), with folders, query params, headers, bodies, form-data files and bearer auth;
- a **web page** that documents every request;
- **Express route files** for every controller, so you never register routes by hand.

Works on Windows, macOS and Linux.

## Installation

Thunder API is a command-line tool written in Dart. Install the [Dart SDK](https://dart.dev/get-dart) (or Flutter), then:

```bash
dart pub global activate thunder_api
```

Make sure the pub cache `bin` folder is on your `PATH` (`dart pub global activate` prints the exact folder if it isn't).

## Annotate your controllers

Put the annotations directly above each exported method:

```javascript
// @desc     Get all addresses
// @route    GET /api/v1/addresses
// @param    {"sort" : "desc", "page" : 1}
// @header   {"lang" : "en"}
// @access   Private (user)
exports.getAddresses = asyncHandler(async (req, res, next) => {
  // ...
});

// @desc     Add user address
// @route    formdata /api/v1/addresses
// @body     {"title" : "Home", "image" : "images/home.png", "option" : {"files_key" : ["image"]}}
// @access   Private (user)
exports.addAddress = asyncHandler(async (req, res, next) => {
  // ...
});
```

| Annotation | Value | Example |
|------------|-------|---------|
| `// @desc` | Request name in the collection | `// @desc Get all addresses` |
| `// @route` | HTTP method (`GET`, `POST`, `PUT`, `PATCH`, `DELETE`) or `formdata`, then the path | `// @route GET /api/v1/addresses` |
| `// @param` | Query parameters, as a JSON object | `// @param {"sort" : "desc"}` |
| `// @header` | Headers, as a JSON object | `// @header {"lang" : "en"}` |
| `// @body` | Body, as a JSON object | `// @body {"name" : "Abd"}` |
| `// @access` | `Public` or `Private (...)`; private requests get bearer auth with `{{token}}` | `// @access Private (user)` |

- `formdata` routes are sent as `POST` with a form-data body. List the keys that are files in `"option": {"files_key": [...]}`; the value of a file key is its path.
- Both `exports.name = ...` and `module.exports.name = ...` are detected. Indented annotations and Windows (CRLF) files work.
- Each controller file becomes one folder in the collection, named after the file without `_controller` (`address_controller.js` → `address`). Sub-folders are scanned too.

A complete sample is in [`example/controllers`](example/controllers).

## Build the API collection

```bash
thunder_api --build-api-doc
```

Thunder API asks for:

1. the collection name,
2. the base URL (saved as the `{{base_url}}` variable),
3. any extra variables (for example `token`, used by private requests),
4. the path of your controllers folder.

It writes everything into `<controllers>/thunder-output/`:

```text
controllers/
└── thunder-output/
    ├── <collection name>.json   ← import this into Postman
    └── web/
        └── index.html           ← open in a browser
```

## Generate Express routes

```bash
thunder_api --build-routes
```

Thunder API asks for the controllers folder and writes one router per controller into a `routes` folder next to it. For the sample above, `routes/address.js` is:

```javascript
const express = require("express");
const router = express.Router();

const {
  getAddresses,
  addAddress,
} = require("../controllers/address_controller");

router.route('/api/v1/addresses').get(getAddresses);
router.route('/api/v1/addresses').post(addAddress);

module.exports = router;
```

## Commands

| Command | Short | What it does |
|---------|-------|--------------|
| `thunder_api --build-api-doc` | `-b` | Postman collection + web docs |
| `thunder_api --build-routes` | `-r` | Express route files |
| `thunder_api --help` | `-h` | Show help |

## Use it from Dart

The parser and the Postman models are exported too, if you want to build a collection without the prompts. See [`example/thunder_api_example.dart`](example/thunder_api_example.dart).

## Contributing

Issues and pull requests are welcome. Before opening a pull request:

```bash
dart format .
dart analyze
dart test
```

## Contact

[WhatsApp](https://wa.me/00972598045064) · [Telegram](https://t.me/Abd_Alftah_Al_shanti)

## License

This project is licensed under the [MIT License](LICENSE).
