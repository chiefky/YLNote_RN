"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

function toForm(data) {
  var formData = new FormData();
  var keyArr = Object.keys(data);

  if (keyArr.length < 1) {
    return {};
  }

  keyArr.map(function (item) {
    formData.append(item, data[item]);
  });
  return formData;
}

function toJsonStr(data) {
  return JSON.stringify(data);
}

function formData(headers, data) {
  if (!headers || !headers['Content-Type'] || headers['Content-Type'] === 'application/x-www-form-urlencoded') {
    return toForm(data);
  }

  switch (headers['Content-Type']) {
    case 'application/json':
      return toJsonStr(data);

    default:
      return toForm(data);
  }
}

var _default = request = function request(_ref) {
  var url = _ref.url,
      method = _ref.method,
      data = _ref.data,
      dataType = _ref.dataType,
      headers = _ref.headers,
      success = _ref.success,
      error = _ref.error,
      complete = _ref.complete;
  console.log(url);
  var options = {}; //默认method

  options['method'] = method || 'GET'; //默认header

  options['headers'] = Object.assign({
    'Content-Type': 'application/x-www-form-urlencoded',
    //默认格式
    'credentials': 'include',
    //包含cookie
    'mode': 'cors' //允许跨域

  }, headers); //处理body

  options.method.toUpperCase() === 'POST' && (options['json'] == data ? formatData(headers, data) : '');
  fetch(url, options).then(function (response) {
    return response.json();
  }).then(function (responseJson) {
    success && success(responseJson);
    complete && complete(responseJson);
  })["catch"](function (err) {
    error && error(err);
    complete && complete();
  });
};

exports["default"] = _default;