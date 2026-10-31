const asyncHandler = require("express-async-handler");

// @desc     Get all addresses
// @route    GET /api/v1/addresses
// @param    {"sort" : "desc", "page" : 1}
// @header   {"lang" : "en"}
// @access   Private (user)
exports.getAddresses = asyncHandler(async (req, res, next) => {
  res.json({ data: [] });
});

// @desc     Add user address
// @route    formdata /api/v1/addresses
// @body     {"title" : "Home", "image" : "images/home.png", "option" : {"files_key" : ["image"]}}
// @access   Private (user)
exports.addAddress = asyncHandler(async (req, res, next) => {
  res.status(201).json({ data: req.body });
});

// @desc     Delete address
// @route    DELETE /api/v1/addresses/:id
// @access   Private (user)
exports.deleteAddress = asyncHandler(async (req, res, next) => {
  res.status(204).end();
});
