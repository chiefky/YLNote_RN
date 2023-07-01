import React, { Component, useState } from "react";
import { NavigationContainer } from '@react-navigation/native';
import { View, Text, ScrollView, Dimensions } from "react-native";
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import EmptyScreen from "./src/pages/EmptyScreen";
import RootNav from './src/route/RootNav';
const window = Dimensions.get('window')

const Tab = createBottomTabNavigator();

function HomeScreen() {
    return (
        <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center', backgroundColor: 'red' }}>
            <Text>Hello world!</Text>
        </View>
    );
}
export default function App() {
    return (
        <NavigationContainer>
            <RootNav></RootNav>
        </NavigationContainer>
    );
}
