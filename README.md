# ⚡ Build Full API Collection and Auto-Generate Routes from Code

This package enables you to build a full API collection directly from your code and automatically generate Express
routes from controllers without adding them manually.

## 🚀 Getting Started

## Usage

Before every method in controllers, write some details about the method to make it more readable. Thunder will use these
details to build the API collection (JSON / Web page) and generate routes.

### 📂 Generate API Documentation

```sh
thunder_api --build-api-doc
```

Use ( // @desc Some description ) to add the request name in the collection.
Use ( // @route GET /api/v1/addresses ) to add the route in the collection.
Use ( // @@param {"sort" : "desc"} ) to add params in the collection.
Use ( // @header {"key" : "this is key"} ) to add headers in the collection.
Use ( // @body {"product_name" : "Iphone 15", "product_image_cover" : "images/iphone15", "option" : {"
files_key" : ["product_image_cover"]}} ) to add body in the collection. (Add an option key when you want to publish
media.)
Use ( // @access Privet (user) ) to add authentication details in the collection.

- Example:

```javascript
// @desc Get all addresses
// @route GET /api/v1/addresses
// @@param {"sort" : "desc"}
// @header {"key" : "this is key"} ) to add headers in the collection.
// @body {"product_name" : "Iphone 15", "product_image_cover" : "images/iphone15", "option" : {"files_key" : ["product_image_cover"]}} ) to add body in the collection. (Add an option key when you want to publish media.)
// @access Privet (user)
```

```javascript
// @desc     Add user address
// @route    formdata /api/v1/addresses
// @param    {"sort" : "desc"}
// @header   {"api_key" : "1kwQTz8Kkc2KWrrUvBvBSkiEZ7RCEQ"}
// @body     {"product_name" : "Iphone 15", "product_image_cover" : "images/iphone15", "option" : {"files_key" : ["product_image_cover"]}}
// @access   Privet (user)
exports.addUserAddressHandler = asyncHandler(async (req, res, next) => {
  // write your code here
});
```

# 🛠️ Auto-Generate Express Routes

```javascript
thunder_api --create-routes
```

This command scans all controllers and generates corresponding Express routes automatically, eliminating the need for
manual route creation.

```javascript
// @desc Register user
// @route POST /auth/register
exports.registerUser = async (req, res) => {
  // Controller logic
};
```

```javascript
const express = require("express");
const router = express.Router();
const { registerUser } = require("../controller/auth_controller");

router.route('/auth/register').post(registerUser);

module.exports = router;
```


Contact with me
---------------

[Whats App](https://wa.me/00972598045064) ||
[Telegram](https://t.me/Abd_Alftah_Al_shanti)

## Contributing

Feel free to contribute to this project by opening issues, suggesting new features, or submitting pull requests.

## License

This project is licensed under the MIT License.