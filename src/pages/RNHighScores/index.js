import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
const scores = [{ name: "张三", value: "90分" }, { name: "李四", value: "93分" }]
class Index extends Component {
    render() {
        var contents = scores.map((score) => (
            <Text key={score.name}>
                {score.name}:{score.value}
                {'\n'}
            </Text>
        ));
        return (
            <View style={styles.container}>
                <Text style={styles.highScoresTitle}>
                    2048 High Scores!
                </Text>
                <Text style={styles.scores}>{contents}</Text>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#FFFFFF'
    },
    highScoresTitle: {
        fontSize: 20,
        textAlign: 'center',
        margin: 10
    },
    scores: {
        textAlign: 'center',
        color: '#333333',
        marginBottom: 5
    }
});
export default Index;