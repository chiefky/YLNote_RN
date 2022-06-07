import React from 'react';
import { View, Text, Button, NativeEventEmitter, NativeModules } from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import SettingScreen from './Setting';
import DetailsScreen from './Details';
const InteractionStack = createStackNavigator();

// createNativeStackNavigator();
const { YLRNTEventManager } = NativeModules;
const calendarManagerEmitter = new NativeEventEmitter(YLRNTEventManager);
const subscription = calendarManagerEmitter.addListener(
    'selectItem',
    (reminder) => {
        console.log("接收到native通知：" + reminder.f_id)
        // this.props.navigation.navigate('Details', {
        //     name: "hello world",
        //     filmId: reminder.f_id,
        // });
    }
);

// const TestScreen = (props) => {
//     return (
//         <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
//             <Text>Setting Screen</Text>
//             <Button
//                 title="Go to Details"
//                 onPress={() => props.navigation.navigate('Details')}></Button>
//         </View>);
// }

class TestScreen extends React.Component {
    render() {
        return (
            <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
                <Text>This is 'TestScreen' </Text>
                <Button
                    title="Go to 'SettingScreen'"
                    onPress={() => this.props.navigation.navigate('Setting')}></Button>
            </View>);
    }
}


class InteractionScreen extends React.Component {
    render() {
        return (
            <NavigationContainer>
                <InteractionStack.Navigator initialRouteName="Test" screenOptions={{
                    headerShown: false
                }} >
                    {/* Details: TypeError: undefined is not an object (evaluating 'route.params.name') */}
                    {/* <InteractionStack.Screen name="Details" component={DetailsScreen} options={({ route }) => ({ title: route.params.name })} /> */}
                    <InteractionStack.Screen name="Setting" component={SettingScreen} options={{ title: "SettingScreen" }} />
                    <InteractionStack.Screen name="Test" component={TestScreen} options={{ title: "TestScreen" }}></InteractionStack.Screen>
                </InteractionStack.Navigator>
            </NavigationContainer>
        );
    }

    componentWillUnmount() {
        subscription.remove()
    }

}

export default InteractionScreen;