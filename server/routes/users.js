var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});

router.post('/login', function(req, res, next) {
  let username = req.body.username;
  let password = req.body.password;

  res.status(200).json({
    
  });
});

module.exports = router;
