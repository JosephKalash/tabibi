const SIGNUP_URL = 'http://$ip:8000/api/patient';
const LOGIN_URL = 'http://$ip:8000/api/patient-login';

const ADD_CONSUL_URL = 'http://$ip:8000/api/consultation';
const GET_CONSULS_URL = 'http://$ip:8000/api/consultation';
const GET_MY_CONS_URL = 'http://$ip:8000/api/patient-consultations';

const SPECIALIZATION_URL = 'http://$ip:8000/api/specializations';

const ADD_RESERVATION_URL = 'http://$ip:8000/api/reservation_requests';
const GET_RESERVATION_URL = 'http://$ip:8000/api/patient-reservations';
const CANCEL_RESERVATION_URL = 'http://$ip:8000/api/reservation_requests';

const DOCTORS_URL = 'http://$ip:8000/api/clinic';

const ip = '192.168.1.4';

const kAuthorization = 'Authorization';
const kBearer = '';

const kPersonInfoPref = 'person';

const kTokenKey = 'token';
const kExpiresInKey = 'expiresIn';
const kPassword = 'password';
const kUserAge = 'age';
const kUserName = 'full_name';
const kUserPhoneNumber = 'phone_number';
const kUserEmail = 'email';

const kConResponse = 'response';
const kResponseDate = 'responseDate';

const kClinicSpecialization = 'clinic_specialization';
const kTitle = 'header';
const kContent = 'content';
const kConsDate = 'date';

const kAddConsErrorMessage = 'لم تنجح عملية إضافة الاستشارة، حاول مرة أخرى';
const kGetConsError = 'لم تنجح عملية طلب الاستشارات، حاول مرة أخرى';

const kSmallSize = 12.0;

const kSpeciId = 'id';
const kSpeciName = 'name';

const kReservationAddErrorMessage = 'لم تنجح عملية إضافة الحجز، حاول مرة أخرى';
const kReservationCancelErrorMessage =
    'لم تنجح عملية إلغاء الحجز، حاول مرة أخرى';
const kGetReservError = 'لم تنجح عملية طلب الحجوزات، حاول مرة أخرى';

const kReservationTime = 'reservation_time';
const kClinicId = 'clinic_Id';
const kReservationDate = 'reservation_date';
const kReservationStatus = 'reservation_status';
const kReservationId = 'reservation_id';

const kDoctorName = 'doctor_name';

const kDoctorSpecialization = 'specialization';
const kDoctorPhoneNumber = 'phone_number';
const kDoctorAddress = 'address';
const kDoctorImagePath = 'image_path';
const kDoctorErrorMessage = 'لم تنجح عملية طلب الأطباء، حاول مرة أخرى';
const kDoctorId = 'id';
