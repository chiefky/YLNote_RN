import React, { Component } from 'react';
import { View, Text, SafeAreaView } from 'react-native';
export default class Home extends Component {
    render() {
        return (
            <SafeAreaView style={{ flex: 1, backgroundColor: 'red' }}>

                <Text style={{ flex: 1 }}>This is Home page!</Text>
                <View style={{ flex: 8, backgroundColor: 'blue' }}>

                </View>
            </SafeAreaView>
        );
    }
}