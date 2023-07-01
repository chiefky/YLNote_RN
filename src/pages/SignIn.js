import { useEffect, useRef, useState } from 'react'
import {
    View, TextInput, TouchableWithoutFeedback,
    Image, Text, SafeAreaView,
    TouchableHighlight, StyleSheet, TouchableOpacity,
} from 'react-native'
import Ionicons from "react-native-vector-icons/Ionicons"
const SignIn = ({ navigation }) => {
    const [disabled, setDisabled] = useState(false);
    const [data, setData] = useState({ hits: [] });
    const [checked, setChecked] = useState(false);
    const [validUserName, setValidUserName] = useState(false);
    const [validPassword, setValidPassword] = useState(false);
    const myRef = useRef(null)
    let otherLogin = ["新用户注册", "短信验证码登录", "忘记密码"]
    useEffect(() => {
        // const fetchData = async () => {
        //     const result = await axios(
        //         'https://hn.algolia.com/api/v1/search?query=redux',
        //     );

        //     setData(result.data);
        // };
        // fetchData();

        console.log('--========')
    }, []);


    checkNickname = (text) => {
        console.log("myRef===", myRef)
        let textValid = text.trim().length >= 2
        setValidUserName(textValid)
        // setLegalUserName(textValid)
        setDisabled(textValid && validPassword)
    }
    handleNickName = () => {

    }
    checkPassword = (text) => {
        let textValid = text.trim().length >= 2
        setValidPassword(textValid)
        // setLegalPassword(textValid)
        setDisabled(textValid && validUserName)
    }
    handlePassword = () => {

    }
    handleChecked = () => {
        let berfore = checked
        console.log('修改前，已阅读：', berfore)
        setChecked(!berfore)
    }
    return (<SafeAreaView style={styles.container}>
        <View style={styles.close}>
            <TouchableOpacity onPress={() => navigation.goBack()}><Ionicons size={20} name='close-outline'></Ionicons></TouchableOpacity>
            <TouchableOpacity onPress={() => {
                navigation.push('Help')
            }}><Text>帮助</Text></TouchableOpacity>
        </View>
        <Image style={styles.avatar} source={{
            uri: 'https://m15.360buyimg.com/mobilecms/jfs/t1/37709/6/15279/6118/60ec1046E4b5592c6/a7d6b66354efb141.png'
        }} />
        <TextInput style={styles.nickname}
            ref={(ref) => myRef.current = ref}
            placeholder='账号名/邮箱/手机号'
            autoCapitalize="none"
            keyboardType="email-address"
            returnKeyType="next"
            clearButtonMode='while-editing'
            onChangeText={text => checkNickname(text)}
            onSubmitEditing={(e) => { handleNickName(e.nativeEvent.text) }} />
        <TextInput style={styles.password}
            placeholder='密码'
            clearButtonMode='while-editing'
            onChangeText={checkPassword}
            onSubmitEditing={(e) => { handlePassword(e.nativeEvent.text) }} />
        <View style={styles.checkBox}>
            <TouchableWithoutFeedback onPress={handleChecked}>
                <View style={{}}>
                    <Ionicons size={(17)} name={!checked ? 'ios-radio-button-off-outline' : 'ios-checkmark-circle-outline'} />
                </View>
            </TouchableWithoutFeedback>
            <Text style={{}} >我已阅读并同意</Text>
            <TouchableWithoutFeedback onPress={() => { navigation.navigate('WebPage') }}>
                <View style={{}}>
                    <Text style={{ color: '#0000ff' }}>《隐私政策》</Text>
                </View>
            </TouchableWithoutFeedback>
        </View>
        <TouchableHighlight style={[styles.login, {
            backgroundColor: 'tomato',
            opacity: !disabled ? 0.2 : 1
        }]}
            onPress={() => {
                console.log("clicked")
            }}
            disabled={disabled}
            activeOpacity={0.2}
        >
            <Text style={{ color: '#fff', fontSize: 17, fontWeight: '800' }}>登录</Text>
        </TouchableHighlight>
        <View style={styles.otherStyle}>
            {
                otherLogin.map((item, index) => {
                    return (<TouchableHighlight onPress={() => {
                        let name = index == 0 ? 'SignUp' : (index == 1 ? 'MessageSignIn' : 'ResetPassword')
                        console.log("点击了：", name, item)
                        navigation.push(name, {
                            from: item
                        })
                    }}>
                        <Text>{item}</Text>
                    </TouchableHighlight>)
                })

            }
        </View>
    </SafeAreaView >)
}


//样式定义
const styles = StyleSheet.create({
    container: {
        flex: 1,
        marginTop: 64,
        marginHorizontal: (15)
    },
    close: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
    },
    avatar: {
        backgroundColor: 'tomato',
        width: 80, height: 80,
        alignSelf: 'center',
        borderRadius: 40
    },
    nickname: {
        backgroundColor: '#dcdcdc',
        height: 40,
        marginTop: 20,
        paddingLeft: (15),
        borderRadius: (20),
        overflow: 'hidden',
    },
    password: {
        backgroundColor: '#dcdcdc',
        height: 40,
        marginTop: 20,
        paddingLeft: (15),
        borderRadius: (20),
        overflow: 'hidden',
    },
    checkBox: {
        marginTop: 20,
        // height: 30,
        flexDirection: 'row',
        alignItems: 'center'
    },
    login: {
        marginTop: 60,
        height: 50,
        borderRadius: (25),
        justifyContent: 'center',
        alignItems: 'center',
    },
    otherStyle: {
        marginTop: 10,
        flexDirection: 'row',
        justifyContent: 'space-around'
    }
});

export default SignIn;
