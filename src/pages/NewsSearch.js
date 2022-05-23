import React from 'react';
import { View, Text, StyleSheet } from 'react-native';

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