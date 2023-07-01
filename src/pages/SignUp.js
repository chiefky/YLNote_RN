import React, { Component } from 'react';
import { View, Text, SafeAreaView, Button, } from 'react-native';
// import { WebView } from 'react-native-webview';

export default class SignUp extends Component {
    render(props) {
        console.log('参数是：', this.props)
        return (

            <SafeAreaView>
                <View style={{ alignItems: 'center' }}>
                    <Text>from:"null"</Text>
                </View>
                <Button title='push to help ' onPress={() => navigation.push('Help', {
                    from: "null",
                })} />
                {/* <WebView
                    source={{ uri: 'https://www.google.com' }}
                    style={{ flex: 1 }}
                /> */}
            </SafeAreaView>
        );
    }
}

