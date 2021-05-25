<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Notebook.aspx.cs" Inherits="NotebookFBCWeb.Notebook" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Users</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/vue"></script>
    <link rel="stylesheet" href="/Content/styleForModal.css" />
    <script type="text/x-template" id="modal-template">
      <transition name="modal">
        <div class="modal-mask">
          <div class="modal-wrapper">
            <div class="modal-container">

              <div class="modal-header">
                <slot name="header">
                  default header
                      
                </slot>
              </div>

              <div class="modal-body">
                <slot name="body">
                  default body
                </slot>
              </div>

              <div class="modal-footer">
                <slot name="footer">

                </slot>
              </div>
            </div>
          </div>
        </div>
      </transition>
    </script>
    <style>
        

    </style>
</head>
<body>  
     <form id="form1" runat="server">
        <div>
            <div id="app">               
                <table class="table table-bordered">
                    <thead class="table-header">
                        <tr>
                            <th>ФИО</th>
                            <th>Номер телефона</th>
                            <th>Email</th>
                            <th>Пол</th>
                            <th>Функции</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="user in items" :key ="user.Id">
                            <td>{{user.Name }}</td>
                            <td>{{user.Phone }}</td>
                            <td>{{user.Email }}</td>
                            <td>{{user.Gender }}</td>
                            <td><button class="btn btn-outline-info" @click.prevent="showModalTwo = !showModalTwo; currentItem=user; WriteData()">Изменить запись</button><button type="button" class="btn btn-outline-info" style="margin-left: 15px" v-on:click="DeleteUser(user)">Удалить запись</button></td>
                        </tr>
                    </tbody>
                </table>
                <div class="modal-mask" v-if="showModalTwo">
                    <div class="modal-wrapper">
                        <div class="modal-container">
                            <div class="modal-header">
                                <h3>Изменить запись в книжке</h3>
                                <button class="close" @click.prevent="showModalTwo = !showModalTwo">&times;</button>                                    
                            </div>
                            <div class="modal-body">
                                <div class="row form-group">
                                    <div class="col-md-12 mb-3 mb-md-0">
                                        <input type="text" v-model="Name" placeholder="Введите ФИО" class="form-control rounded">
                                    </div>
                                </div>
                                <div class="row form-group">
                                    <div class="col-md-12 mb-3 mb-md-0">
                                        <input type="text" v-model="Phone" placeholder="Введите номер телефона" class="form-control rounded">
                                    </div>
                                </div>
                                <div class="row form-group">
                                    <div class="col-md-12 mb-3 mb-md-0">
                                        <input type="text" v-model="Email" placeholder="Введите Email" class="form-control rounded">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="exampleFormControlSelect2">Выберите пол:</label>
                                    <select class="form-control" id="exampleFormControlSelect2" v-model="Gender">
                                        <option value="Male">Мужской</option>
                                        <option value="Female">Женский</option>
                                    </select>
                                </div>
                                <div class="row form-group">
                                    <div class="col-md-12 mb-3 mb-md-0">
                                        <button type="button" class="btn btn-outline-info" v-on:click="ChangeUser()">Изменить
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <p v-if="errors.length">
                                    <b>Пожалуйста, исправьте данные ошибки:</b>
                                    <ul>
                                        <li v-for="error in errors">{{ error }}</li>
                                    </ul>
                                </p>
                            </div>
                    </div>
                </div>
            </div>
        </div>
        </div>
    </form>

    <div id="add">
        <button type="button" class="btn btn-outline-info" @click="showModal = true">Добавить запись</button>
        <modal v-if="showModal" @close="showModal = false">
        <h3 slot="header">Добавить запись в книжку</h3>
        <button slot="header" class="close" @click.prevent="showModal = !showModal">&times;</button> 
        <div slot="body">
            <div class="row form-group">
                <div class="col-md-12 mb-3 mb-md-0">
                    <input type="text" v-model="Name" placeholder="Введите ФИО" class="form-control rounded">
                </div>
            </div>
            <div class="row form-group">
                <div class="col-md-12 mb-3 mb-md-0">
                    <input type="text" v-model="Phone" placeholder="Введите номер телефона" class="form-control rounded">
                </div>
            </div>
            <div class="row form-group">
                <div class="col-md-12 mb-3 mb-md-0">
                    <input type="text" v-model="Email" placeholder="Введите Email" class="form-control rounded">
                </div>
            </div>
            <div class="form-group">
                <label for="exampleFormControlSelect1">Выберите пол:</label>
                <select class="form-control" id="exampleFormControlSelect1" v-model="Gender">
                    <option value="Male">Мужской</option>
                    <option value="Female">Женский</option>
                </select>
            </div>
            <div class="row form-group">
                <div class="col-md-12 mb-3 mb-md-0">
                    <button type="button" class="btn btn-outline-info" v-on:click="OnSubmit()">Добавить</button>
                </div>
            </div>
        </div>
        <div slot="footer">
             <p v-if="errors.length">
                <b>Пожалуйста, исправьте данные ошибки:</b>
                <ul>
                    <li v-for="error in errors">{{ error }}</li>
                </ul>
             </p>
        </div>>
        </modal>
    </div>  
    <script type="text/javascript">
        let vueApp = new Vue({
            el: '#app',
            data: {
                showModalTwo: false,
                items: [],
                Id: '',
                Name: '',
                Phone: '',
                Email: '',
                Gender: '',
                errors: []

            },

            created: function () {
                let cobject = this; 
                let ObjectD = { "Id": this.Id,"Name": this.Name, "Phone": this.Phone, "Email": this.Email, "Gender": this.Gender };
                $.ajax({
                    type: "POST",
                    url: "NotebookMethods.asmx/GetUsers",
                    data: JSON.stringify(ObjectD),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        cobject.items = JSON.parse(data.d);
                        
                    }
                });
            },

            methods: {
                DeleteUser: function (el) {
                    $.ajax({
                        type: "POST",
                        url: "NotebookMethods.asmx/DeleteUsers",
                        data: JSON.stringify({ "user": el }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            window.location.reload();
                        },
                        error: function (data) {
                            console.log(JSON.stringify({ "Id": el }));
                        }
                    });
                },
                validEmail: function (Email) {
                    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                    return re.test(Email);
                },
                validPhone: function (Phone) {
                    var re = /^[\d]{11}$/;
                    return re.test(Phone);
                },
                WriteData: function () {
                    this.Id = currentItem.Id;
                    this.Name = currentItem.Name;
                    this.Phone = currentItem.Phone;
                    this.Email = currentItem.Email;
                    this.Gender = currentItem.Gender.trim();

                },

                ChangeUser: function (el) {
                    var ObjectD = { "Id": this.Id, "Name": this.Name, "Phone": this.Phone, "Email": this.Email, "Gender": this.Gender };
                    this.errors = [];
                    if (!this.Name) this.errors.push("Введите пожалуйста имя");
                    if (!this.Phone) {
                        this.errors.push("Введите пожалуйста номер");
                    }
                    else if (!this.validPhone(this.Phone)) {
                        this.errors.push("Некорректно введен номер телефона");
                    }
                    if (!this.Email) {
                        this.errors.push("Введите пожалуйста Email");
                    }
                    else if (!this.validEmail(this.Email)) {
                        this.errors.push("Некорректно введен Email");
                    }
                    if (!this.errors.length) {
                        $.ajax({
                            type: "POST",
                            url: "NotebookMethods.asmx/ChangeUsers",
                            data: JSON.stringify({ "user": ObjectD }),
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                window.location.reload();
                            },
                            error: function (data) {
                                console.log(JSON.stringify({ "Id": el }));
                            }
                        });
                    }
                }
            },
            

        });

        Vue.component("modal", {
            template: "#modal-template"
        });

        
        new Vue({
            el: "#add",
            data: {
                errors: [],
                showModal: false,
                Name: '',
                Phone: '',
                Email: '',
                Gender: ''
            },
            
            methods: {
                validEmail: function (Email) {
                    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                    return re.test(Email);
                },
                validPhone: function (Phone) {
                    var re = /^[\d]{11}$/;
                    return re.test(Phone);
                },
                OnSubmit: function (el) {
                    var ObjectD = { "Name": this.Name, "Phone": this.Phone, "Email": this.Email, "Gender": this.Gender };
                    this.errors = [];
                    if (!this.Name) this.errors.push("Введите пожалуйста имя");
                    if (!this.Phone) {
                        this.errors.push("Введите пожалуйста номер");
                    }
                    else if (!this.validPhone(this.Phone)) {
                        this.errors.push("Некорректно введен номер телефона");
                    }
                    if (!this.Email) {
                        this.errors.push("Введите пожалуйста Email");
                    }
                    else if (!this.validEmail(this.Email)) {
                        this.errors.push("Некорректно введен Email");
                    }
                    if (!this.errors.length) {
                        $.ajax({
                            type: "POST",
                            url: "NotebookMethods.asmx/AddUsers",
                            data: JSON.stringify({ "user": ObjectD }),
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                window.location.reload();
                            }

                        });
                    }
                }
            }
        });
    </script>
</body>  
</html>
