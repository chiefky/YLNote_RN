import React, { Component } from 'react';
import { View, Text, Button, StyleSheet, SafeAreaView, Image } from 'react-native';
import { screenWidth } from '../utils/stylesKit';

// }
const styles = StyleSheet.create({
    container: {
        // alignItems: "center",
        flex: 1,
        backgroundColor: "#fff",
        // borderWidth: 1,
        padding: 15,
        // margin: 10
    },
    topArea: {
        flex: 3,
        cover: {
            width: "100%",
            height: 150,
            backgroundColor: 'lightgray'
        },
        title: {
            color: "#000",
            fontSize: 16,
            fontWeight: "700",
            lineHeight: 28
        },
        subtitle: {
            fontSize: 14,
            marginTop: 5
        },
        score: {
            fontSize: 20,
            fontWeight: 'bold',
            color: 'red'
        }
    },
    midArea: {
        flex: 2,
        backgroundColor: 'green',
    },
    bottomArea: {
        flex: 3,
        backgroundColor: 'blue',
    },

});

const DetailsInfoContainer = (props) => {
    console.log("props.title:", props.title);
    return (<View style={styles.container}>
        {/* 插图 */}
        <View style={styles.topArea}>
            {/* banner */}
            <Image
                style={styles.topArea.cover}
                source={{ uri: props.movie_banner }}
                resizeMode={"center"}
            />
            <Text style={styles.topArea.title}>{props.title}({props.original_title})</Text>
            <View style={{ flexDirection: 'row' }}>
                <Text style={styles.topArea.subtitle}>评分：</Text>
                <Text style={styles.topArea.score}>{props.rt_score}</Text>
            </View>
            <Text style={styles.topArea.subtitle}>上映时间：{props.release_date}</Text>
            <Text style={styles.topArea.subtitle}>播放次数：{props.running_time}</Text>
            <Text style={styles.topArea.subtitle}>导演：{props.director}</Text>
            <Text style={styles.topArea.subtitle}>電影製作人：{props.producer}</Text>
            <Text numberOfLines={0} style={styles.topArea.subtitle}>简介：{props.description}</Text>

        </View>
        {/* <View style={styles.midArea}></View> */}
    </View>)
}

class DetailsScreen extends Component {
    constructor(props) {
        super(props);
        this.state = {
            film: {},

        };

    }
    getInfo = (filmId) => {

        let info = this.state.infoList;
        let str = "https://ghibliapi.herokuapp.com/films/" + filmId
        console.log("地址：", str)
        fetch(str).then((res) => res.json())
            .then((res) => {
                if (res) {
                    // console.log("data:", res);
                    this.setState({
                        film: res
                    });
                }
            });
    };

    render() {
        const { film } = this.state;
        console.log('params: ', typeof film);
        return (<SafeAreaView style={{ flex: 1 }}>
            {/* <Text> Hello Detail!</Text> */}
            <DetailsInfoContainer {...film}></DetailsInfoContainer>
        </SafeAreaView>);
    }

    componentDidMount() {
        // const { route, navigation } = this.props;
        console.log("参数：" + this.props)
        var filmId = ''
        if (typeof (this.props.route) == "undefined") {
            // 从原生加载详情页
            filmId = this.props.filmId
            console.log("从原生传递filmId：" + filmId)
        } else {
            // 从react加载原生页
            filmId = this.props.route.params.filmId;
            console.log('从路由传递filmId:', filmId)
        }
        this.getInfo(filmId)

        // let params = this.props.route.params;
        // let props = this.props;
        // let filmId = JSON.stringify(params.filmId);
        // console.log("navigation ", navigation)
    }

}

export default DetailsScreen;

