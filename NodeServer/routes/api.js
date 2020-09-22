const express = require("express");
const apiRouter = express.Router();

const User = require("../models/User");

apiRouter
  .route("/user")
  .get(function (req, res) {
    User.find(function (err, users) {
      if (err) res.send(err);
      res.json(users);
    });
  })
  .post(function (req, res) {
    if (!req.body.mobile || !req.body.password) {
      return res.json({ success: false, error: "Fill up all the field" });
    }
    User.insertUser(req.body.mobile, req.body.password, (status, err, data) => {
      if (status === 200) {
        return res.json({
          success: true,
          authorized: true,
          user: data,
        });
      } else {
        return res.json({
          success: false,
          authorized: true,
          //user: req.user,
          error: err,
        });
      }
    });
    // // const user = new User();
    // // user.name = req.body.name;
    // // user.mobile = req.body.mobile;
    // // user.password = req.body.password;

    // console.log(req.body);
    // return res.json({ success: false, error: "Internal Server down" });
    // // User.save(function (err, doc) {
    // //   if (err) res.send(err);
    // //   res.json(doc);
    // // });
  });
apiRouter.post("/login", function (req, res) {
  // render the page and pass in any flash data if it exists

  if (!req.body.mobile || !req.body.password) {
    return res.json({ success: false, error: "Fill up all the field" });
  }
  User.checkUser(req.body.mobile, req.body.password, function (
    status,
    err,
    user
  ) {
    if (status != 200) {
      return res.json({ success: false, error: err });
    } else {
      //let token = jwt.sign(user.toJSON(), config.secret);
      //console.log(req.body + "res");
      return res.json({
        success: true,
        token: "JWT " + user.mobile,
        user: user,
      });
    }
  });

  //console.log(req.body+"req");
});
module.exports = apiRouter;
