import 'package:enjoy_your_brace/data_collection_devices/data_collection_devices.dart';
import 'package:test/test.dart';

DataList prepareData(
    {required double frequency,
    required double variability,
    required double offset,
    required int numberOfHours}) {
  final device = SimulatedTemperatureDevice(
      frequency: frequency, variability: variability, offset: offset);

  final data = DataList(dataCollector: device);
  device.simulateData(null, numberOfHours, dataList: data);
  return data;
}

void main() {
  group('Testing DataList', () {
    test('Accessors', () {
      final dataList = prepareData(
          frequency: 2, variability: 2, offset: 0, numberOfHours: 1);
      expect(dataList.earliest, dataList[0]);
      expect(dataList.latest, dataList[dataList.length - 1]);
      expect(
          dataList.latest.date.difference(dataList.earliest.date).inHours, 1);
    });

    test('Test reseting of the randomizer', () {
      final dataList = prepareData(
          frequency: 2, variability: 2, offset: 0, numberOfHours: 24 * 30);
      expect(dataList.totalWearingTime, 550.0);
      expect(dataList.meanWearingTimePerDay, 55 / 3);
    });

    test('Test computation of wearing times (random wearing time)', () {
      final dataList = prepareData(
          frequency: 2, variability: 2, offset: 0, numberOfHours: 24 * 30);
      expect(dataList.totalWearingTime, 550.0);
      expect(dataList.meanWearingTimePerDay, 55 / 3);
    });

    test('Test computing of wearing times (wore all the time)', () {
      final dataList = prepareData(
          frequency: 2, variability: 2, offset: 1, numberOfHours: 24 * 30);
      expect(dataList.totalWearingTime, 720.0);
      expect(dataList.meanWearingTimePerDay, 24.0);
    });

    test('Test computing of wearing times (never wore)', () {
      final dataList = prepareData(
          frequency: 2, variability: 2, offset: -1, numberOfHours: 24 * 30);
      expect(dataList.totalWearingTime, 0.5);
      expect(dataList.meanWearingTimePerDay, 1 / 60);
    });
  });
}
