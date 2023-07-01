import React, { useState } from 'react';
import { SafeAreaView, Text, TouchableHighlight, View } from "react-native";

export default function Interaction(props) {
    const [stackInfo, setStackInfo] = useState("Hello world!")
    const [content, setContent] = useState("Hello world!")

    return (<SafeAreaView style={{ flex: 1 }}>
        <View style={{ flex: 1, }}>
            <View style={{ height: 40, justifyContent: 'center', backgroundColor: 'green', padding: 10 }}><Text>JS调用OC方法,打印一下原生页面的路由堆栈：</Text></View>
            <Text style={{ backgroundColor: '#ccc', padding: 10 }}>{stackInfo ?? "null"}</Text>
            <View style={{ height: 40, justifyContent: 'center', backgroundColor: 'orange', padding: 10 }}><Text>OC调JS方法,ToDo List:</Text></View>
            <Text style={{ backgroundColor: '#ccc', padding: 10 }}>{content ?? "null"}</Text>
        </View>
        <View style={{ flex: 2, alignItems: 'center', }}>
            <TouchableHighlight style={{ width: 200, height: 40, backgroundColor: 'green', justifyContent: 'center', alignItems: 'center', marginVertical: 10 }}
                onPress={() => {
                    console.log("js调oc")
                }}>
                <Text>JS调用OC方法</Text>
            </TouchableHighlight>
            <TouchableHighlight style={{ width: 200, height: 40, backgroundColor: 'orange', justifyContent: 'center', alignItems: 'center', }}
                onPress={() => {
                    console.log("oc调js")
                }}>
                <Text>OC调JS方法</Text>
            </TouchableHighlight>
        </View>
    </SafeAreaView>)
};
