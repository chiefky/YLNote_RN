import React from 'react';
import { Text, View, TouchableOpacity, SafeAreaView } from 'react-native';
import { Input } from 'react-native-elements';
import Svg, { SvgCss, SvgUri, SvgCssUri } from 'react-native-svg';
import { male, female } from "../../../res/fonts/iconSvg";
import { pxToDp } from "../../../utils/stylesKit";
import YLButton from "../../../components/YLButton";
import DatePicker from "react-native-datepicker";

class Index extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            nickname: '',
            gender: '',
            birthday: '',
            city: '',
            header: '',
            lng: '',
            lat: '',
            address: '',
        }
    }

    async compomentDidUpdate() {
        const res = "北京"
        console.log(res);
        const address = res.regeocode.formatted_address;
        const city = res.regeocode.addressComponent.city.replace('市', '');
        const lng = res.regeocode.addressComponent.streetNumber.location.split(
            ',',
        )[0];
        const lat = res.regeocode.addressComponent.streetNumber.location.split(
            ',',
        )[1];
        this.setState({ address, city, lng, lat });

    }

    chooeseGender = (gender) => {
        this.setState({ gender })
    }

    chooeseHeadImg = () => {

    }

    render() {
        const { nickname, gender, birthday, city } = this.state;
        const dateNow = new Date();
        const currentDate = `${dateNow.getFullYear()}-${dateNow.getMonth() + 1
            }-${dateNow.getDate()}`;
        return (
            <SafeAreaView style={{
                flex: 1
            }}>
                <View style={{ backgroundColor: '#fff', flex: 1, padding: pxToDp(20) }}>
                    {/* 1.0 标题 开始 */}
                    <Text style={{ fontSize: pxToDp(20), color: '#666', fontWeight: 'bold' }}>
                        填写资料</Text>
                    <Text style={{ fontSize: pxToDp(20), color: '#666', fontWeight: 'bold' }}>
                        提升我的魅力</Text>
                    {/* 2.0 性别 开始 */}
                    <View style={{ marginTop: pxToDp(20) }}>
                        <View
                            style={{
                                justifyContent: 'space-around',
                                width: '60%',
                                flexDirection: 'row',
                                alignSelf: 'center',
                            }}>
                            <TouchableOpacity
                                onPress={this.chooeseGender.bind(this, '男')}
                                style={{
                                    width: pxToDp(60),
                                    height: pxToDp(60),
                                    borderRadius: pxToDp(30),
                                    backgroundColor: gender === '男' ? 'red' : '#ADD8E6',
                                    justifyContent: 'center',
                                    alignItems: 'center',
                                }}>
                                <SvgCss xml={male} width="36" height="36" />

                            </TouchableOpacity>
                            <TouchableOpacity
                                onPress={this.chooeseGender.bind(this, '女')}
                                style={{
                                    width: pxToDp(60),
                                    height: pxToDp(60),
                                    borderRadius: pxToDp(30),
                                    backgroundColor: gender === '女' ? 'red' : '#FFF5EE',
                                    justifyContent: 'center',
                                    alignItems: 'center',
                                }}>
                                <SvgCss xml={female} width="36" height="36" />
                            </TouchableOpacity>
                        </View>
                    </View>
                    {/* 2.0 性别 结束 */}
                    {/* 3.0 昵称 开始 */}
                    <View>
                        <Input
                            value={nickname}
                            placeholder="设置昵称"
                            onChangeText={(nickname) => this.setState({ nickname })}
                        />
                    </View>
                    {/* 3.0 昵称 结束 */}
                    {/* 4.0 日期 开始 */}
                    <View>
                        <DatePicker
                            androidMode="spinner"
                            style={{ width: '100%' }}
                            date={birthday}
                            mode="date"
                            placeholder="设置生日"
                            format="YYYY-MM-DD"
                            minDate="1900-01-01"
                            maxDate={currentDate}
                            confirmBtnText="确定"
                            cancelBtnText="取消"
                            customStyles={{
                                dateIcon: {
                                    display: 'none',
                                },
                                dateInput: {
                                    marginLeft: pxToDp(10),
                                    borderWidth: 0,
                                    borderBottomWidth: pxToDp(1.1),
                                    alignItems: 'flex-start',
                                    paddingLeft: pxToDp(4),
                                },
                                placeholderText: {
                                    fontSize: pxToDp(18),
                                    color: '#afafaf',
                                },
                            }}
                            onDateChange={(birthday) => {
                                this.setState({ birthday });
                            }}
                        />
                    </View>
                    {/* 4.0 日期 结束 */}
                    {/* 5.0 地址 开始 */}
                    <View style={{ marginTop: pxToDp(20) }}>
                        <TouchableOpacity onPress={this.showCityPicker}>
                            <Input
                                value={'当前定位:' + city}
                                inputStyle={{ color: '#666' }}
                                disabled={true}
                            />
                        </TouchableOpacity>
                    </View>
                    {/* 5.0 地址 结束 */}

                    {/* 6.0 选择头像 开始 */}
                    <View>
                        <YLButton
                            onPress={this.chooeseHeadImg}
                            style={{
                                height: pxToDp(40),
                                borderRadius: pxToDp(20),
                                alignSelf: 'center',
                            }}>
                            设置头像
                        </YLButton>
                    </View>
                    {/* 6.0 选择头像 结束 */}
                </View>
            </SafeAreaView >);
    }
}


export default Index;