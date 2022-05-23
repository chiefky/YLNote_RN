import { Dimensions } from "react-native";
/**
 * 屏幕宽度
 */
export const screenWidth = Dimensions.get('window').width;
/**
 * 屏幕高度
 */
export const screenHeight = Dimensions.get('window').height;
/**
 * 
 * @param {*} elePx 设计稿给出的控件大小（px为单位）
 * @returns 显示大小（dp为单位）
 */
export const pxToDp = (elePx) => screenWidth * elePx / 375;