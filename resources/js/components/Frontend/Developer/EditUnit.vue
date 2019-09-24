<template>
  <div>
    <div class="uk-card dashboard-content">
      <ul class="uk-breadcrumb">
        <li><a :href="$root.url + '/developer/project/dashboard'">Dashboard</a></li>
        <li><a :href="$root.url + '/developer/project/manage_project'">Kelola Proyek</a></li>
        <li><a :href="$root.url + '/developer/project/detail/' + getproject.project_unique_id">{{ getproject.project_name }}</a></li>
        <li><span>Edit Unit</span></li>
      </ul>
      <div class="uk-card-title uk-margin dashboard-content-heading">Edit Unit - {{ getunit.unit_name }}</div>
      <div v-show="errors.errorMessage" class="uk-alert-danger" uk-alert>{{ errors.errorMessage }}</div>
      <form class="uk-form-stacked" @submit.prevent="onAddUnit">
        <div class="uk-margin">
          <button class="uk-button uk-button-primary dash-btn" v-html="forms.submit"></button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  props: ['session_user', 'getproject', 'getfacility', 'getunit'],
  data() {
    return {
      forms: {
        submit: 'Simpan Perubahan',
      },
      errors: {
        name: {},
        errorMessage: '',
        iserror: false
      },
      formRequired: '<span class="uk-text-danger">*</span>'
    }
  },
  methods: {
    onEditUnit()
    {

    }
  },
  mounted() {

  }
}
</script>
