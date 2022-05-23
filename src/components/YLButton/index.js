import React, { Component } from 'react';
import { Text, TouchableOpacity, StyleSheet } from 'react-native';
import LinearGradient from 'react-native-linear-gradient';
import { pxToDp } from '../../utils/stylesKit';

class Index extends React.Component {
    static defaultProps = {
        style: {},
        textStyle: {},
        disabled: false,
    };

    render() {
        return (
            <TouchableOpacity
                disabled={this.props.disabled}
                onPress={this.props.onPress}
                style={{ ...styles.touchableOpacity, ...this.props.style }}
            >
                <LinearGradient
                    start={{ x: 0, y: 0 }}
                    end={{ x: 1, y: 0 }}
                    colors={this.props.disabled ? ['#A9A9A9', '#DCDCDC'] : ['#9b63cd', '#e0708c']}
                    style={styles.linearGradient}
                >
                    <Text style={{ ...styles.buttonText, ...this.props.textStyle }}>
                        {this.props.children}
                    </Text>
                </LinearGradient>
            </TouchableOpacity >
        );
    }
}


const styles = StyleSheet.create({
    touchableOpacity: {
        width: '100%',
        height: '100%',
        overflow: 'hidden',
    },
    linearGradient: {
        flex: 1,
        paddingLeft: pxToDp(15),
        paddingRight: pxToDp(15),
        borderRadius: pxToDp(5),
        width: '100%',
        height: '100%',
        justifyContent: 'center',
        alignItems: 'center',
    },
    buttonText: {
        fontSize: pxToDp(18),
        fontFamily: 'Gill Sans',
        textAlign: 'center',
        color: '#ffffff',
        backgroundColor: 'transparent',
    },
});

export default Index;