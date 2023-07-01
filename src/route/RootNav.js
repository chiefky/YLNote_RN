import { Component } from "react";
import { createNativeStackNavigator } from '@react-navigation/native-stack';
// import { createBottomTabNavigator } from "@react-navigation/bottom-tabs";
import EmptyScreen from "../pages/EmptyScreen";

// function HomeTabs() {
//     return (
//         <Tab.Navigator>
//             <Tab.Screen name="Home" component={Home} options={{ title: '首页' }} />
//             <Tab.Screen name="Cart" component={EmptyScreen} options={{ title: '购物车' }} />
//             <Tab.Screen name="User" component={EmptyScreen} options={{ title: '个人' }} />
//         </Tab.Navigator>
//     );
// }

// const Tab = createBottomTabNavigator()
const Stack = createNativeStackNavigator();
export default class RootNav extends Component {

    render() {
        return (<Stack.Navigator>
            {/* <Stack.Screen name="Home" component={HomeTabs} /> */}
            <Stack.Screen name="Camera" component={EmptyScreen} />
            <Stack.Screen name="Scan" component={EmptyScreen} />
        </Stack.Navigator>)
    }
};
