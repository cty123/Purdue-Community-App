var express = require('express');
var router = express.Router();
const User = require('../models/user');
const jwt = require('jsonwebtoken');
const passport = require('passport');

/* GET users listing. */
router.get('/', function (req, res, next) {
  res.send('respond with a resource');
});

router.post('/register', async (req, res, next) => {
  const username = req.body.username;
  const password = req.body.password;
  const email = req.body.email;

  if (!username || !password || !email) {
    res.status(201).json({
      status: "Failed",
      message: "Error username or password or email address"
    });
    return;
  }

  let existing_user = await User.findOne().or([
    { 'username': username },
    { 'email': email },
  ]);

  if (existing_user) {
    if (existing_user.username == username) {
      res.status(200).json({
        'status': 'Failed',
        'message': 'Username already in use',
      });
      return;
    }
    if (existing_user.email == email) {
      res.status(200).json({
        'status': 'Failed',
        'message': 'Email already in use',
      });
      return;
    }
  }

  let new_user = new User();
  new_user.username = username;
  new_user.email = email;
  new_user.password = new_user.hashPassword(password);
  new_user.token = jwt.sign(new_user.id, 'your_jwt_secret');
  
  try {
    new_user.save();
    res.status(200).json({
      'status': 'Success',
      'user': new_user,
    });
    return;
  } catch (err) {
    console.log(err);
    res.status(200).json({
      'status': 'Failed',
      'message': 'Database error',
      'error': err,
    });
    return;
  }
});

router.post('/login', async (req, res, next) => {

  passport.authenticate('local', { session: false }, (err, user, info) => {
    if (err || !user) {
      return res.status(400).json({
        'status': 'Failed',
        'message': err,
      });
    }

    req.login(user, { session: false }, (err) => {
      if (err) {
        res.json({
          "message": err,
          status: "Failed"
        });
        return;
      }

      const token = jwt.sign(user.id, 'your_jwt_secret');
      
      user.token = token;
      user.save();

      return res.json({ 
        status: "Success",
        user, 
      });
    });
  })(req, res);
});

module.exports = router;
