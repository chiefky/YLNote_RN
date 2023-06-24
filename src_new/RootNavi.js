import React from 'react';
import { View, Text } from 'react-native';
import { createStackNavigator } from '@react-navigation/stack';
import { TouchableHighlight, StyleSheet } from 'react-native';
const Stack = createStackNavigator();// createNativeStackNavigator();
function EmptyScreen(props) {
    console.log("打印一下属性：", props);
    const { navigation, route } = props
    return (<View style={{ flex: 1 }}>
        <View style={{ flex: 1, backgroundColor: 'pink', justifyContent: 'space-around' }}>
            <Text style={{ textAlign: 'center' }}>this is a null page！</Text>
        </View>
        <View style={{ flex: 8, backgroundColor: '#ccc' }}>
            <TouchableHighlight style={styles.Button} onPress={() => {
                console.log('push to details!')
                navigation.push("News")
            }}>
                <Text>Details</Text>
            </TouchableHighlight>
            <TouchableHighlight style={styles.Button} >
                <Text>News</Text>
            </TouchableHighlight>
            <TouchableHighlight style={styles.Button} >
                <Text>NewsSearch</Text>
            </TouchableHighlight>
            <TouchableHighlight style={styles.Button} >
                <Text>Setting</Text>
            </TouchableHighlight>
        </View>

    </View>)
}
export default RootNavStack = () => {

    return (
        <>
            <Stack.Navigator initialRouteName="Details" screenOptions={{
                headerMode: 'screen',
                headerTintColor: 'white',
                headerStyle: { backgroundColor: '#DE643E' },
            }}>
                <Stack.Screen name="Details" component={EmptyScreen} options={{ title: "Details" }} />
                <Stack.Screen name="News" component={EmptyScreen} options={{ title: "ReactNative" }}></Stack.Screen>
                <Stack.Screen name="NewsSearch" component={EmptyScreen} options={({ route }) => ({ title: route.params.name })}></Stack.Screen>
                <Stack.Screen name="Setting" component={EmptyScreen} options={{ title: "SettingScreen" }}></Stack.Screen>
            </Stack.Navigator>
        </>
    );
}

const styles = StyleSheet.create({
    Button: {
        height: 60,
        backgroundColor: 'yellow',
        color: 'orange',

    }
});