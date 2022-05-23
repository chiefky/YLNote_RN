import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
class Index extends Component {
    render() {
        var contents = this.props['scores'].map((score) => (
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