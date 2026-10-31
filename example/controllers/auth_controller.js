// @desc     Register user
// @route    POST /api/v1/auth/register
// @body     {"name" : "Abd", "email" : "abd@example.com", "password" : "123456"}
// @access   Public
exports.register = async (req, res) => {
  res.status(201).json({ token: "..." });
};

// @desc     Log in
// @route    POST /api/v1/auth/login
// @body     {"email" : "abd@example.com", "password" : "123456"}
// @access   Public
exports.login = async (req, res) => {
  res.json({ token: "..." });
};
