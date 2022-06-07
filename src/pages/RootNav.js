import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import SettingScreen from './Setting';
import DetailsScreen from './Details';
import NewsScreen from './News';
import NewsSearchScreen from './NewsSearch';
const Stack = createStackNavigator();// createNativeStackNavigator();

export default RootNav = () => {

    return (
        <NavigationContainer>
            <Stack.Navigator initialRouteName="News" screenOptions={{
                headerMode: 'screen',
                headerTintColor: 'white',
                headerStyle: { backgroundColor: '#DE643E' },
            }}>
                <Stack.Screen name="Details" component={DetailsScreen} options={({ route }) => ({ title: route.params.name })} />
                <Stack.Screen name="News" component={NewsScreen} options={{ title: "ReactNative" }}></Stack.Screen>
                <Stack.Screen name="NewsSearch" component={NewsSearchScreen} options={({ route }) => ({ title: route.params.name })}></Stack.Screen>
                <Stack.Screen name="Setting" component={SettingScreen} options={{ title: "SettingScreen" }}></Stack.Screen>
            </Stack.Navigator>
        </NavigationContainer>
    );
}