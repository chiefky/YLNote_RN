import React from 'react';
import { View, Text, Button, NativeEventEmitter, NativeModules } from 'react-native';
const { YLRNTEventManager } = NativeModules;
const calendarManagerEmitter = new NativeEventEmitter(YLRNTEventManager);
const subscription = calendarManagerEmitter.addListener(
    'selectItem',
    (reminder) => {
        console.log("接受到native通知：" + reminder.f_id)
        // this.props.navigation.navigate('Details', {
        //     name: "hello world",
        //     filmId: reminder.f_id,
        // });
    }
);

class Interaction extends React.Component {
    render() {
        return (<View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
            <Text>Setting Screen</Text>
            <Button
                title="Go to Details"
                onPress={() => this.props.navigation.navigate('Details')}></Button>
        </View>);
    }

    componentWillUnmount() {
        subscription.remove()
    }

}

export default Interaction;