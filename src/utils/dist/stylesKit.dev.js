"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.pxToDp = exports.screenHeight = exports.screenWidth = void 0;

var _reactNative = require("react-native");

/**
 * 屏幕宽度
 */
var screenWidth = _reactNative.Dimensions.get('window').width;
/**
 * 屏幕高度
 */


exports.screenWidth = screenWidth;

var screenHeight = _reactNative.Dimensions.get('window').height;
/**
 * 
 * @param {*} elePx 设计稿给出的控件大小（px为单位）
 * @returns 显示大小（dp为单位）
 */


exports.screenHeight = screenHeight;

var pxToDp = function pxToDp(elePx) {
  return screenWidth * elePx / 428;
};

exports.pxToDp = pxToDp;