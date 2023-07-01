import React from 'react';
import { View, Text } from 'react-native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import DetailScreen from '../pages/Details';
import HomeScreen from '../pages/Home';

const Stack = createNativeStackNavigator();

function RootSatck() {
    return (
        <Stack.Navigator >
            <Stack.Screen name="Home" options={{ headerShown: false }} component={HomeScreen} />
            <Stack.Screen name="Detail" options={{ headerShown: false }} component={DetailScreen} />
            <Stack.Screen name="Empty" options={{ headerShown: false }} component={HomeScreen} />
            <Stack.Screen name="Help" options={{ headerShown: false }} component={HomeScreen} />
        </Stack.Navigator>
    );
}


export default RootSatck;