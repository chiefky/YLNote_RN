
export default {

    validatePhone(phone) {
        const reg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
        return reg.test(phone)
    },

    privatePhone(phone) {
        const reg = /(\d{3})\d{4}(\d{4})/; //正则表达式
        return phone.replace(reg, "$1****$2");
    }
}