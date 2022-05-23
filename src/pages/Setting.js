import React from 'react';
import { View, Text, Button } from 'react-native';
class SettingScreen extends React.Component {
    render() {
        return (<View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
            <Text>Setting Screen</Text>
            <Button
                title="Go to Details"
                onPress={() => this.props.navigation.navigate('Details')}></Button>
        </View>);
    }
}

export default SettingScreen;