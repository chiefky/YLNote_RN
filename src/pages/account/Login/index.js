import React, { Component } from 'react';
import { View, Text, Button, Image, StatusBar, SafeAreaView, StyleSheet, CodeFiled } from 'react-native';
import { Input } from "react-native-elements";
import {
    CodeField,
    Cursor,
} from 'react-native-confirmation-code-field';
import { pxToDp } from '../../../utils/stylesKit';
import validator from "../../../utils/validator";
import request from "../../../utils/request";
import pathMap, { ACCOUNT_LOGIN, ACCOUNT_VALIDATEVCODE } from "../../../utils/pathMap";
import YLButton from '../../../components/YLButton'
import UserInfo from "../UserInfo";
class Index extends React.Component {
    state = {
        showLogin: true,// 显示登录页面
        phoneNumber: "18900871234",
        phoneValid: true,// 手机号合法
        vcText: '',// 验证码value
        btnText: '重新获取',// 按钮文本
        isCountdowning: false,// 是否倒计时中
    }
    phoneNumberChangeText = (phoneNumber) => {
        this.setState({ phoneNumber })
    }
    phoneNumberSubmitEditing = async () => {
        /**
         * 手机号合法性校验：1 不通过-> 提示
         * 将手机号发送后台接口验证并获取验证码
         * 切换成验证码页面
         */
        const { phoneNumber } = this.state;
        const phoneValid = validator.validatePhone(phoneNumber);
        this.setState({ phoneValid });
        if (!phoneValid) {
            alert("手机号非法")
            return;
        }

        this.setState({ showLogin: false });
        // 开启定时器
        this.countdown();
        return;
        const res = await request.post(ACCOUNT_LOGIN, { phone: phoneNumber })
        console.log(res)
        alert('heoo')
        if (res.code === '10000') {
            // 请求成功
            this.setState({ showLogin: false });
            // 开启定时器
            this.countdown();
        } else {
            alert("请求失败")
        }
    }

    // 开启获取验证码的定时器
    countdown = () => {
        if (this.state.isCountdowning) {
            return;
        }
        this.setState({ isCountdowning: true });
        let seconds = 2;
        // 重新获取(5s)
        this.setState({ btnText: `重新获取(${seconds}s)` });
        const { btnText } = this.state;
        let timerId = setInterval(() => {
            seconds--;
            this.setState({ btnText: `重新获取(${seconds}s)` });
            if (seconds === 0) {
                clearInterval(timerId);
                this.setState({ btnText: '重新获取', isCountdowning: false });
            }
        }, 1000);
    };
    // 验证码输入框的值改变事件
    onVcodeChangeText = (vcodeTxt) => {
        this.setState({ vcodeTxt });
    };

    // 验证码输入完毕事件
    onVcodeSubmitEditing = async () => {
        /**
         * 1 对验证码做校验 长度
         * 2 将手机号码和验证码一起发送到后台
         * 3 返回值 有 isNew
         *    isNew 为true 新用户 -> 完善个人信息的页面
         *    isNew 为false 老用户 -> 交友 - 首页
         */
        const { vcodeTxt, phoneNumber } = this.state;
        if (vcodeTxt.length !== 6) {
            Toast.message('验证码不正确', 2000, 'center');
            return;
        }

        const res = await request.post(ACCOUNT_VALIDATEVCODE, {
            phone: phoneNumber,
            vcode: vcodeTxt,
        });
        if (res.code !== '10000') {
            console.log(res);
            return;
        }
        if (res.data.isNew) {
            // 新用户 UserInfo
            this.props.navigation.navigate('UserInfo');
        } else {
            // 老用户
            alert('老用户 跳转交友页面');
        }
    };

    /**
     * 重新获取验证码
     */
    reGetVcode = () => {
        this.props.navigation.navigate('UserInfo');
        return;
        this.countdown();
    }
    render() {
        const { showLogin } = this.state;
        return <SafeAreaView style={{ flex: 1 }}>
            <Image
                style={styles.profileBg}
                source={require('../../../res/images/back.jpeg')}
            />
            <View style={styles.loginContainer}>
                {showLogin ? this.renderLogin() : this.renderVcode()}
            </View>
        </SafeAreaView>
    }
    /**
    * 登录界面
    */
    renderLogin = () => {
        const { phoneNumber, phoneValid } = this.state;
        return (
            <View>

                <Text style={styles.loginLabel}>手机号登录注册</Text>
                <View style={{ marginTop: pxToDp(10) }}>
                    <Input
                        placeholder='请输入手机号码'
                        maxLength={11}
                        keyboardType='phone-pad'
                        value={phoneNumber}
                        inputStyle={styles.phoneInput}
                        onChangeText={this.phoneNumberChangeText}
                        onSubmitEditing={this.phoneNumberSubmitEditing}
                        errorStyle={{ color: 'red' }}
                        errorMessage={phoneValid ? "" : '手机号码格式不正确'}
                    />
                </View>
                <View>
                    <YLButton
                        onPress={this.phoneNumberSubmitEditing}
                        style={styles.ylButton}>
                        获取验证码
                    </YLButton>
                </View>
            </View>
        );
    }

    /** 
     * 获取验证码界面
    */
    renderVcode = () => {
        const { phoneNumber, vcodeTxt, btnText, isCountdowning } = this.state;
        return (
            <View>
                <View>
                    <Text style={styles.vcodeText1}>输入6位验证码</Text>
                </View>
                <View style={{ marginTop: pxToDp(10) }}>
                    <Text style={styles.vcodeText2}>已发送到:+86{validator.privatePhone(phoneNumber)}</Text>
                </View>
                <View>
                    <CodeField
                        value={vcodeTxt}
                        onChangeText={this.onVcodeChangeText}
                        onSubmitEditing={this.onVcodeSubmitEditing}
                        // 输入密码框的个数
                        cellCount={6}
                        rootStyle={styles.codeFiledRoot}
                        keyboardType="phone-pad"
                        renderCell={({ index, symbol, isFocused }) => (
                            <View
                                key={index}
                                style={[styles.cell, isFocused && styles.focusCell]}
                            >
                                <Text>{symbol || (isFocused ? <Cursor /> : null)}</Text>
                            </View>

                        )}
                    />
                </View>
                <View style={{ marginTop: pxToDp(30) }}>
                    <YLButton
                        disabled={isCountdowning}
                        onPress={this.reGetVcode}
                        style={styles.ylButton}>
                        {btnText}
                    </YLButton>

                </View>

            </View>
        );
    }
}

const styles = StyleSheet.create({
    profileBg: {
        width: '100%',
        height: pxToDp(220), // 单位dp
    },
    loginContainer: {
        padding: pxToDp(20),
    },
    loginLabel: {
        fontSize: pxToDp(25),
        color: '#888',
        fontWeight: 'bold',
    },
    phoneInput: {
        color: '#333',
    },
    ylButton: {
        width: '85%',
        height: pxToDp(40),
        alignSelf: 'center',
        borderRadius: pxToDp(20),
    },
    vcodeText1: {
        fontSize: pxToDp(25),
        color: '#888',
        fontWeight: 'bold',
    },
    vcodeText2: {
        color: '#888',
    },
    codeFieldRoot: {
        marginTop: 20,
        width: 280,
        marginLeft: 'auto',
        marginRight: 'auto',
    },
    cell: {
        width: 40,
        height: 40,
        justifyContent: 'center',
        alignItems: 'center',
        borderBottomColor: '#A9A9A9',
        borderBottomWidth: 1,
    },
    cellText: {
        color: '#000',
        fontSize: 36,
        textAlign: 'center',
    },
    focusCell: {
        borderBottomColor: '#9b63cd',
        borderBottomWidth: 2,
    },
});

export default Index;
