const mongoose = require("mongoose");
const Schema = mongoose.Schema;
var bcrypt = require("bcrypt-nodejs");

const UserSchema = new Schema({
  mobile: {
    type: String,
    required: true,
  },
  password: {
    type: String,
    required: true,
  },
});

UserSchema.statics.insertUser = function (mobile, password, cb) {
  this.findOne({ mobile: mobile }, function (err, user) {
    if (!user) {
      const newUser = new User({
        mobile: mobile,
      });
      newUser.password = newUser.generateHash(password);
      newUser.save(function (err) {
        if (err) {
          return cb(500, "Internal Server Error", null);
        }
        return cb(200, null, newUser);
      });
    } else {
      return cb(400, "Mobile Number already exist", null);
    }
  });
};

// generating a hash
UserSchema.methods.generateHash = function (password) {
  return bcrypt.hashSync(password, bcrypt.genSaltSync(8), null);
};

// checking if password is valid
UserSchema.methods.validPassword = function (password, password2) {
  return bcrypt.compareSync(password, password2);
};
UserSchema.statics.getUser = function (cb) {
  this.find(function (err, users) {
    if (err) cb(400, "Data not found", null);
    else {
      cb(200, null, users);
    }
  });
};
UserSchema.statics.checkUser = function (mobile, password, cb) {
  var that = this;
  this.findOne({ mobile: mobile }, function (err, user) {
    if (err) cb(500, "Server error", null);
    if (!user) {
      cb(404, "User not found", null);
    } else {
      if (user.validPassword(password, user.password)) {
        cb(200, null, user);
      } else {
        cb(300, "Mobile Number & Password don't match", null);
      }
    }
  });
};

module.exports = User = mongoose.model("User", UserSchema);
