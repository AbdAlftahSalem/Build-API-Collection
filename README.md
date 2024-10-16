# ⚡ Build Full API Collection directly from code.

This package enables you to build full API collection directly from code without added it manually .

## 🚀 Getting started ( BETA )

## Usage

Before every method in controllers write some details about method to make it more readable
and Thunder will use this details to build API collection ( JSON / Web page )


- Use ( // @desc Some of description ) to add request name in collection
- Use ( // @route GET /api/v1/addresses ) to add route in collection
- Use ( // @@param {"sort" : "desc"} ) to add params in collection
- Use ( // @header {"key" : "this is key"} ) to add headers in collection
- Use ( // @body {"product_name" : "Iphone 15", "product_image_cover" : "images/iphone15", "option" : {"
  files_key" : ["product_image_cover"]}}) to add body in collection ( Add option key when you want to
  publish media )
- Use ( // @access   Privet (user) ) to add Auth in collection

```javascript

// @desc     Add user address
// @route    formdata /api/v1/addresses
// @param    {"sort" : "desc"}
// @header   {"api_key" : "1kwQTz8Kkc2KWrrUvBvBSkiEZ7RCEQ"}
// @body      // @body {"product_name" : "Iphone 15", "product_image_cover" : "images/iphone15", "option" : {"files_key" : ["product_image_cover"]}}
// @access   Privet (user)
exports.addUserAddressHandler = asyncHandler(async (req, res, next) => {
  // write you code here
});
```

Contact with me
---------------

[Whats App](https://wa.me/00972598045064) ||
[Telegram](https://t.me/Abd_Alftah_Al_shanti)

## Contributing

Feel free to contribute to this project by opening issues, suggesting new features, or submitting pull requests.

## License

This project is licensed under the MIT License.