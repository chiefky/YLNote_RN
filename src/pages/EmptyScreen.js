import React, { useEffect, useState } from 'react';
import { Text, Button, View } from 'react-native';
function EmptyScreen({ navigation, route }) {
    const [count, setCount] = useState(0);
    useEffect(() => {
        if (navigation) {
            navigation.setOptions({
          
            });
        }
    }, [navigation]);

    let name = "null"
    let from = "null"
    if (route) {
        const { params } = route;
        console.log("参数是", params)
        name = route.name
        from = params && params.from ? params.from : "undefined"
    }

    return <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center', backgroundColor: '#cdcdcd' }}>
        <Text numberOfLines={2}>This is <Text style={{ color: 'red', fontSize: 18, fontWeight: 500 }}>{name}</Text> Page, from: {from} </Text>
        {navigation ? <Button title='退出' onPress={() => navigation.goBack()} /> : null}
    </View>;
}
export default EmptyScreen;