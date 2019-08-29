@extends('frontend.pages.developer.master')
@section('tag_title', 'Developer Dashboard')
@section('main_content')
<div style="height: 474px;" class="uk-padding uk-overflow-auto">
  <div class="uk-grid-small uk-grid-match" uk-grid>
    @for( $i = 0; $i < 10; $i++ )
    <div class="uk-width-1-3">
      <div class="uk-card uk-card-default">
        <div class="uk-card-media-top">
          <img src="{{ asset('images/banner/homepage1.jpg') }}" alt="">
        </div>
        <div class="uk-card-body">
          <h3 class="uk-card-title">Media Top</h3>
          <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.</p>
        </div>
      </div>
    </div>
    @endfor
  </div>
</div>
@endsection
