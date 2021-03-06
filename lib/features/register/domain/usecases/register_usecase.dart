import 'package:my_app/features/register/domain/repositories/i_register_repository.dart';
import 'package:my_app/features/register/infra/models/request/check_existing_user_request_model.dart';
import 'package:my_app/features/register/infra/models/request/register_user_request_model.dart';
import 'package:my_app/features/register/infra/models/response/check_existing_user_response_model.dart';
import 'package:my_app/features/register/infra/models/response/register_user_response_model.dart';

abstract class IRegisterUsecase {
  Future<CheckExistingUserResponseModel> userExists(CheckExistingUserRequestModel userExistsRequestModel);

  Future<RegisterUserResponseModel> register(RegisterUserRequestModel registerUserRequestModel);
}

class RegisterUsecase implements IRegisterUsecase {
  final IRegisterRepository registerRepository;

  RegisterUsecase(this.registerRepository);

  @override
  Future<CheckExistingUserResponseModel> userExists(CheckExistingUserRequestModel userExistsRequestModel) async {
    var resultModel = await registerRepository.userExists(userExistsRequestModel);

    return resultModel.fold((left) {
      return CheckExistingUserResponseModel(success: false, message: left.message);
    }, (right) {
      return CheckExistingUserResponseModel(success: true, userExists: right.userExists);
    });
  }

  @override
  Future<RegisterUserResponseModel> register(RegisterUserRequestModel registerUserRequestModel) async {
    var resultModel = await registerRepository.register(registerUserRequestModel);

    return resultModel.fold((left) {
      return RegisterUserResponseModel(success: false, message: left.message);
    }, (right) {
      return RegisterUserResponseModel(success: true, message: right.message);
    });
  }
}