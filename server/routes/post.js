var express = require("express");
var router = express.Router();
var multer = require("multer");
const Post = require("../models/post");
const Comment = require("../models/comment");
const path = require("path");

// File upload settup
var storage = multer.diskStorage({
  destination: function(req, file, cb) {
    cb(null, "./public/uploads");
  },
  filename: function(req, file, cb) {
    cb(
      null,
      req.user.id +
        "-" +
        file.fieldname +
        "-" +
        Date.now() +
        path.extname(file.originalname)
    );
  }
});

// Set parser and limit
var upload = multer({ storage: storage }).array("imgs", 5);

router.get("/", async (req, res, next) => {
  // Get page from the request query
  let page = req.query.page;

  // Check if the user has specified a page
  if (!page) {
    // Perform first query to get the totalPages
    page = 1;

    // Perform the first query to get the total number of pages
    let response = await Post.paginate(
      {},
      { populate: "user", page: page, limit: 2, sort: { date: 1 } }
    );

    // Assign the maxpage to the user
    page = response.totalPages;

    // Perform the second query to actually fetch the data
    let posts = await Post.paginate(
      {},
      { populate: "user", page: page, limit: 2, sort: { date: 1 } }
    );

    // Return JSON
    res.status(201).json({
      status: "Success",
      posts: posts.docs,
      page: posts.page,
      totalPages: posts.totalPages
    });
  } else {
    // If the user specifies a page, we simply return that page
    let posts = await Post.paginate(
      {},
      { populate: "user", page: page, limit: 2, sort: { date: 1 } }
    );

    // Return JSON
    res.status(201).json({
      status: "Success",
      posts: posts.docs,
      page: posts.page,
      totalPages: posts.totalPages
    });
  }
});

router.post("/", upload, async (req, res, next) => {
  // Get parsed parameters
  const { title, content } = req.body;
  console.log(req.body);
  // Get user
  let user = req.user;

  // Check title
  if (!title) {
    res.json({
      status: "Failed",
      message: "No title"
    });
    return;
  }

  // Check content
  if (!content) {
    res.json({
      status: "Failed",
      message: "No content"
    });
    return;
  }

  let p = new Post();
  p.title = title;
  p.content = content;
  p.user = user;

  for (i in req.files) {
    let fn = req.files[i].filename;
    p.images.push(fn);
  }

  await p.save();

  // Return file url
  res.status(201).json({
    status: "Success",
    post: p
  });
});

router.get("/comment", async (req, res, next) => {
  // Obtain the post_id and page from the http query
  var { post_id, page } = req.query;

  // Check if the user has specified a page
  if (!page) {
    // Get the first page by default
    page = 1;
  }

  try {
    // Grab the post by the provided post id
    let post = await Post.findById(post_id);

    // Check if the post exists
    if (!post) {
      // Return failed error
      res.status(200).json({
        status: "Failed",
        message: "No post found"
      });
      return;
    }

    // Get response from mongoose query
    let response = await Comment.paginate(
      { post: post },
      { populate: "user", page: page, limit: 2, sort: { date: 1 } }
    );

    // Return result
    res.status(200).json({
      status: "Success",
      comments: response.docs,
      page: response.page,
      totalPages: response.totalPages
    });
  } catch (e) {
    // Return failed message
    res.status(200).json({
      status: "Failed",
      message: "Database Error"
    });
  }
});

router.post("/comment", async (req, res, next) => {
  // Get query from http request body
  const { post_id, content } = req.body;

  // Obtain the operation user
  let user = req.user;

  // Check if the content is null
  if (!content) {
    // Return failure message
    res.status(200).json({
      status: "Failed",
      message: "Empty content is not allowed"
    });
    return;
  }

  try {
    // Get post object
    p = await Post.findById(post_id);

    // Check if the post exists
    if (!p) {
      // Return failure message
      res.status(200).json({
        status: "Failed",
        message: "No post found"
      });
      return;
    }

    // Construct a new comment object
    let c = new Comment();

    // Set the content of the comment object
    c.content = content;

    // Assign user to the object
    c.user = user;

    // Link post id
    c.post = p;

    // Wait for saving
    await c.save();

    // Add the comment to the post
    p.comments.push(c);

    // Save the post
    await p.save();

    // Return success message
    res.status(200).json({
      status: "Success",
      post: c
    });
  } catch (e) {
    res.status(200).json({
      status: "Failed",
      message: "Database Error"
    });
  }
});

router.post("/edit", async (req, res, next) => {
  const { post_id, title, content } = req.body;

  // Get post by the provided id
  try {
    let post = await Post.findById(post_id).populate("user");

    // Check if the post owner is the requester
    if (!post.user._id.equals(req.user._id)) {
      res.status(200).json({
        status: "Failed",
        message: "Not authorized to edit this post"
      });
      return;
    }

    // Change and save the title and content
    post.title = title;
    post.content = content;
    await post.save();

    // Return success message
    res.status(200).json({
      status: "Success",
      message: "Success"
    });
  } catch (e) {
    print(e);
    res.status(200).json({
      status: "Failed",
      message: "Database Error"
    });
  }
});
module.exports = router;
