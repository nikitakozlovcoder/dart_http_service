## Usage


```dart
const http = HttpServiceImpl();

final myModel = http.get<MyModel>('example.com', MyModel.fromJson);
```
