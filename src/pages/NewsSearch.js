import React from 'react';
import { View, Text, StyleSheet, NativeEventEmitter, NativeModules } from 'react-native';
const { RNTEventManager } = NativeModules;
const calendarManagerEmitter = new NativeEventEmitter(RNTEventManager);
const subscription = calendarManagerEmitter.addListener(
    'selectItem',
    (reminder) => {
        console.log(reminder)
    }
);
class NewsSearchScreen extends React.Component {
    render() {
        const { naviagetion, route } = this.props;
        // console.log("route", route);
        return (<View style={styles.container}>
            <View style={styles.headerContainer}>
                <Text>显示搜索框，并在didMount时触发第一响应</Text>
            </View>
            <View style={styles.mainContainer}>
                <Text>显示"{route.params.keyword}"搜索结果</Text>
            </View>
        </View>);
    }

    componentWillUnmount() {
        subscription.remove()
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        paddingTop: 0
    },
    headerContainer: {
        backgroundColor: 'lightgray',
        height: 45
    },
    mainContainer: {
        height: '100%',
        backgroundColor: 'gray'
    }
});

export default NewsSearchScreen;