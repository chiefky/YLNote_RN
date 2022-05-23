// In Index.js in a new project

// In App.js in a new project

import * as React from 'react';
import { View, Text, Button, SafeAreaView } from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
// import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { createStackNavigator } from '@react-navigation/stack';

import SettingScreen from '../Setting';
import DetailsScreen from '../Details';
import NewsScreen from '../News';

const Stack = createStackNavigator();// createNativeStackNavigator();

function Index() {

    return (
        <NavigationContainer>
            <Stack.Navigator initialRouteName="News">
                <Stack.Screen name="Details" component={DetailsScreen} options={({ route }) => ({ title: route.params.name })} />
                <Stack.Screen name="News" component={NewsScreen} options={{ title: "ReactNative" }}></Stack.Screen>
                <Stack.Screen name="Setting" component={SettingScreen} options={{ title: "SettingScreen" }}></Stack.Screen>
            </Stack.Navigator>
        </NavigationContainer>
    );

}

export default Index;